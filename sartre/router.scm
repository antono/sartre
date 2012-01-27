(define-module (sartre router)
  #:version (0 0 1)
  #:use-module (web server)
  #:use-module (web request)
  #:use-module (web response)
  #:use-module (web uri)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-13)
  #:use-module (ice-9 pretty-print)
  #:use-module (ice-9 format)
  #:export (route sartre))

(define routes (make-hash-table))

(map (lambda (method)
       (hash-set! routes method (make-hash-table)))
     '(GET POST DELETE PUT))

(define (route method path handler)
  (hash-set! (hash-ref routes method) path handler))

(define (not-found-handler request body)
  (values '((content-type . (text/plain)))
            "404 - Page not found"))

(hash-set! routes 404 not-found-handler)

(define (request-path-components request)
  (split-and-decode-uri-path
   (uri-path (request-uri request))))

(define (find-path-handler method path)
  (let ((method-routes (hash-ref routes method)))
    (or (hash-ref method-routes path)
        (hash-ref routes 404))))

(define (request-path request)
  (let ((components (request-path-components request)))
    (string-append "/"
                   (if (eqv? '() components)
                       ""
                       (car components)))))

(define (find-request-handler request)
  (let* ((path (request-path request))
         (method (request-method request))
         (handler (find-path-handler method path)))
    (format #t "=> ~s: ~s\n" method path)
    (display "=> handler: ") (pretty-print handler)
    handler))

(define (router request body)
  ((find-request-handler request) request body))

(define (sartre port)
  (let ((port (if (number? port)
                  port
                  8080)))
    (format #t "\n=> Starting Sartre on port ~s\n" port)
    (run-server router 'http `(#:port ,port))))
