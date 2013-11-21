(defun is-conflict (item inlist)
   (if (equal inlist nil) nil
       (if (is-binded-to-same-constant item (car inlist))
       t
       (is-conflict item (rest inlist)))))

(defun is-binded-to-same-constant (item1 item2)
   (if (equal (second item1) (second item2))
       t
       nil))
 
(defun has-another-pair (item inlist)
   (if (equal inlist nil) nil
       (if (is-binded-to-same-constant item (car inlist))
       t
       (is-conflict item (rest inlist)))))

;;Insert one  (?var const) pair to 
;;an existing unifier_list like the following
;;(((?Z A) (?X B)) ((?Z A) (?X M)) ((?Z A) (?X CAT)))
;;(setq b_list '((?Z A) (?Z B) (?Z Table)))
(defun Insert-to-Each (binding unifier_list)
  (if (equal unifier_list nil) (return-from Insert-to-Each nil))
  (if (equal binding nil) (return-from Insert-to-Each unifier_list))
  (let
      ((H_ONE (cons binding (first unifier_list)))
       (H_TWO (Insert-to-Each binding (rest unifier_list))))
    (cond 
     ((has-another-pair binding (first unifier_list)) H_TWO)
     (t (cons H_ONE H_TWO)))
    )
  )

(defun unify-list (var_const_pair_list)
  (cond 
   ((equal var_const_pair_list nil) nil)
   (t (cons (list (first var_const_pair_list)) 
	    (unify-list (rest var_const_pair_list))))
   )
  )
(defun Combine (u_list1 u_list2)
  (cond
    ((equal u_list1 nil) u_list2)
    (t (cons (first u_list1) 
	     (Combine (rest u_list1) u_list2))))
  )

;;b_list ---> binding list
;;u_list ---> unifier list
(defun Put (b_list u_list)
  (if (equal b_list nil) (return-from Put nil))
  (if (equal u_list nil) (return-from Put (Unify-list b_list)))
  (let ((H_ONE (Insert-to-Each (first b_list) u_list))
	(H_TWO (Put (rest b_list) u_list)))
    (Combine H_ONE H_TWO))
  )
;;Bind var with the const_list and
;;return a list of ( ?varialb constant ) pair
;;Input:
;;var ---> '?z
;;const_list ---> '(A DOG C TABLE)
;;Output:
;;For (make-binding '?z '(A DOG C TABLE))
;;((?Z A) (?Z DOG) (?Z C) (?Z TABLE))
(defun make-binding (var const_list)
  (cond
   ((equal const_list nil) nil)
   (t (cons (list var (car const_list)) 
	    (make-binding var (rest const_list)))))
  )

(defun distinct-bindings (var_list const_list)
  (if (equal var_list nil) (return-from distinct-bindings nil))
  (let ((H_ONE (make-binding (first var_list) const_list))
	(H_TWO (distinct-bindings (rest var_list) const_list)))
    (cond
     (t (Put H_ONE H_TWO)))
    )
  )

