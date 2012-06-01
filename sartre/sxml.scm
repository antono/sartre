(library (sartre sxml)
         (export sxml->xml
                 list->html-table
                 make-sxml-table
                 make-sxml-table-row
                 make-sxml-table-column)

         (import (rnrs (6))
                 (srfi :13)
                 (sxml simple))

         (define (list->html-table table port)
           (sxml->xml (make-sxml-table table) port))

         (define (make-sxml-table list)
           `(table ,(map make-sxml-table-row list)))

         (define (make-sxml-table-row list)
           `(tr ,(map make-sxml-table-column list)))

         (define (make-sxml-table-column value)
           `(td ,value)))
