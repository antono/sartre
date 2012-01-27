(import (sartre sxml)
        (sartre router))

(define framework-list
  '((Framework Language Note)
    (Sinatra   Ruby     Simple)
    (Rails     Ruby     Fat)
    (Valum     Vala     Fast)
    (Valum     Vala     Fast)
    (Sartre    Scheme   Experimental)))

(define (hello-handler request body)
  (values '((content-type . (text/html)))
          (lambda (port)
            (list->html-table framework-list port))))

(define (world-handler request body)
  (values '((content-type . (text/plain))) "World"))

(define (main-handler request body)
  (values '((content-type . (text/html)))
          (lambda (port)
            (sxml->xml
             '((head
                (title "Sartre - Web Framework for Scheme"))
               (body
                (blockquote
                 "Freedom is what you do with what's been done to you.
                 --- Jean-Paul Sartre")
                (ul
                 (li (a (@ (href "/hello")) "Hello"))
                 (li (a (@ (href "/world")) "World"))
                 (li (a (@ (href "http://community.schemewiki.org/?sxml-example")) "SXML")))))
             port))))

(route 'GET "/hello" hello-handler)
(route 'GET "/world" world-handler)
(route 'GET "/" main-handler)

(sartre 8080)
