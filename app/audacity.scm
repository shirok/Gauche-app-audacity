;;;
;;; Control Audacity via mod-script-pipe
;;;

(define-module app.audacity
  (use gauche.net)
  (use file.util)
  (use rfc.json)

  (export audacity-available? audacity-connect
          audacity-close audacity-send)
  )
(select-module app.audacity)

(define *pipes*
  (cond-expand
   [gauche.os.windows '#("\\\\.\\pipe\\ToSrvPipe"
                         "\\\\.\\pipe\\FromSrvPipe")]
   [else              `#(,#"/tmp/audacity_script_pipe.to.~(sys-getuid)"
                         ,#"/tmp/audacity_script_pipe.from.~(sys-getuid)")]))

(define (audacity-available?)
  (and (file-is-writable? (~ *pipes* 0))
       (file-is-readable? (~ *pipes* 1))))

(define-class <audacity> ()
  ((to-pipe   :init-keyword :to-pipe)
   (from-pipe :init-keyword :from-pipe)))

(define (audacity-connect)
  (unless (audacity-available?)
    (error "Audacity not running?"))
  (let ([to   (open-output-file (~ *pipes* 0) :buffering :none)]
        [from (open-input-file (~ *pipes* 1) :buffering :none)])
    (make <audacity> :to-pipe to :from-pipe from)))

(define (audacity-close aud)
  (close-port (~ aud 'to-pipe))
  (close-port (~ aud 'from-pipe)))

(define (audacity-send aud cmd)
  (define (send)
    (display cmd (~ aud 'to-pipe))
    (display "\n" (~ aud 'to-pipe))
    (flush (~ aud 'to-pipe)))
  (define (recv)
    (let loop ((r '()))
      (let1 line (read-line (~ aud'from-pipe))
        (if (or (eof-object? line)
                (equal? line ""))
          (string-join (reverse r) "\n")
          (loop (cons line r))))))
  (define (parse r)
    (guard (e [(<json-parse-error> e) `(raw-response ,r)]
              [else (raise e)])
      (parse-json-string r)))

  (send)
  (parse (recv)))
  
