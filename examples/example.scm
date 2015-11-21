(import (sartre sxml)
        (sartre router))

(define framework-table
  '((Framework Language Note)
    (Sinatra   Ruby     Simple)
    (Rails     Ruby     Fat)
    (Valum     Vala     Fast)
    (Valum     Vala     Fast)
    (Sartre    Scheme   Experimental)))

(define list-items
  '(ul ol li))

(define (hello-handler request body)
  (values '((content-type . (text/html)))
          (lambda (port)
            (list->html-table framework-table port))))

(define (world-handler request body)
  (values '((content-type . (text/plain))) "World"))

(define (list-handler request body)
  (values '((content-type . (text/html)))
    (lambda (port)
      (list->html-list list-items port))))

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
                 (li (a (@ (href "/list")) "List"))
                 (li (a (@ (href "http://community.schemewiki.org/?sxml-example")) "SXML")))))
             port))))

(route 'GET "/hello" hello-handler)
(route 'GET "/world" world-handler)
(route 'GET "/list"  list-handler)
(route 'GET "/" main-handler)

(sartre 8080)
