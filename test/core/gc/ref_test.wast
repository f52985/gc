(module
  (type $t0 (struct))
  (type $t1 (sub $t0 (struct (field i32))))
  (type $t1' (sub $t0 (struct (field i32))))
  (type $t2 (sub $t1 (struct (field i32 i32))))
  (type $t2' (sub $t1' (struct (field i32 i32))))
  (type $t3 (sub $t0 (struct (field i32 i32))))
  (type $t0' (sub $t0 (struct)))
  (type $t4 (sub $t0' (struct (field i32 i32))))

  (table 20 (ref null data))

  (func $init
    (table.set (i32.const 0) (struct.new_canon_default $t0))
    (table.set (i32.const 10) (struct.new_canon_default $t0))
    (table.set (i32.const 1) (struct.new_canon_default $t1))
    (table.set (i32.const 11) (struct.new_canon_default $t1'))
    (table.set (i32.const 2) (struct.new_canon_default $t2))
    (table.set (i32.const 12) (struct.new_canon_default $t2'))
    (table.set (i32.const 3) (struct.new_canon_default $t3))
    (table.set (i32.const 4) (struct.new_canon_default $t4))
  )

  (func (export "test-sub")
    (call $init)
    (block $l
      ;; must hold
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 0)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 1)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 2)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 3)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 4)))))

      (br_if $l (i32.eqz (ref.test_canon $t1 (table.get (i32.const 1)))))
      (br_if $l (i32.eqz (ref.test_canon $t1 (table.get (i32.const 2)))))

      (br_if $l (i32.eqz (ref.test_canon $t2 (table.get (i32.const 2)))))

      (br_if $l (i32.eqz (ref.test_canon $t3 (table.get (i32.const 3)))))

      (br_if $l (i32.eqz (ref.test_canon $t4 (table.get (i32.const 4)))))

      ;; must not hold
      (br_if $l (ref.test_canon $t0 (ref.null data)))
      (br_if $l (ref.test_canon $t1 (ref.null data)))
      (br_if $l (ref.test_canon $t2 (ref.null data)))
      (br_if $l (ref.test_canon $t3 (ref.null data)))
      (br_if $l (ref.test_canon $t4 (ref.null data)))

      (br_if $l (ref.test_canon $t1 (table.get (i32.const 0))))
      (br_if $l (ref.test_canon $t1 (table.get (i32.const 3))))
      (br_if $l (ref.test_canon $t1 (table.get (i32.const 4))))

      (br_if $l (ref.test_canon $t2 (table.get (i32.const 0))))
      (br_if $l (ref.test_canon $t2 (table.get (i32.const 1))))
      (br_if $l (ref.test_canon $t2 (table.get (i32.const 3))))
      (br_if $l (ref.test_canon $t2 (table.get (i32.const 4))))

      (br_if $l (ref.test_canon $t3 (table.get (i32.const 0))))
      (br_if $l (ref.test_canon $t3 (table.get (i32.const 1))))
      (br_if $l (ref.test_canon $t3 (table.get (i32.const 2))))
      (br_if $l (ref.test_canon $t3 (table.get (i32.const 4))))

      (br_if $l (ref.test_canon $t4 (table.get (i32.const 0))))
      (br_if $l (ref.test_canon $t4 (table.get (i32.const 1))))
      (br_if $l (ref.test_canon $t4 (table.get (i32.const 2))))
      (br_if $l (ref.test_canon $t4 (table.get (i32.const 3))))

      (return)
    )
    (unreachable)
  )

  (func (export "test-canon")
    (call $init)
    (block $l
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 0)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 1)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 2)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 3)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 4)))))

      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 10)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 11)))))
      (br_if $l (i32.eqz (ref.test_canon $t0 (table.get (i32.const 12)))))

      (br_if $l (i32.eqz (ref.test_canon $t1' (table.get (i32.const 1)))))
      (br_if $l (i32.eqz (ref.test_canon $t1' (table.get (i32.const 2)))))

      (br_if $l (i32.eqz (ref.test_canon $t1 (table.get (i32.const 11)))))
      (br_if $l (i32.eqz (ref.test_canon $t1 (table.get (i32.const 12)))))

      (br_if $l (i32.eqz (ref.test_canon $t2' (table.get (i32.const 2)))))

      (br_if $l (i32.eqz (ref.test_canon $t2 (table.get (i32.const 12)))))

      (return)
    )
    (unreachable)
  )
)

(invoke "test-sub")
(invoke "test-canon")