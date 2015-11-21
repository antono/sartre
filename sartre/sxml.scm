(define-module (sartre sxml)
  #:version (0 0 1)
  #:use-module (sxml simple)
  #:export (list->html-table
            list->html-list)
  #:re-export (sxml->xml))

;;
;; HTML Formatting Helpers
;;

;; Table helpers
(define (list->html-table table port)
  (sxml->xml (make-sxml-table table) port))

(define (make-sxml-table list)
  `(table ,(map make-sxml-table-row list)))

(define (make-sxml-table-row list)
  `(tr ,(map make-sxml-table-column list)))

(define (make-sxml-table-column value)
  `(td ,value))

;; List helpers
(define (list->html-list list port)
  (sxml->xml (make-sxml-list list) port))

(define (make-sxml-list list)
  `(ul ,(map make-sxml-list-item list)))

(define (make-sxml-list-item value)
  `(li ,value))
