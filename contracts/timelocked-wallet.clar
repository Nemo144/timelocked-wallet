
;; title: timelocked-wallet
;; version:
;; summary:
;; description:

;; traits
;;

;; token definitions
;;

;; constants
    (define-constant contract-owner tx-sender)

;; data vars
    (define-data-var beneficiary (optional principal) none)
    (define-data-var unlock-height uint u0)
;;

;; data maps
;;

;; public functions
    (define-public (lock (new-beneficiary principal) (unlock-at uint) (amount uint))
    (begin 
     (asserts! (is-eq tx-sender contract-owner) err-owner-only)
     (asserts! (is-none (var-get beneficiary)) err-already-locked)
     (asserts! (> unlock-at block-height) err-unlock-in-past)
     (asserts! (> amount u0) err-no-value)
     (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
     (var-set beneficiary (some new-beneficiary))
     (var-set unlock-height unlock-at)
     (ok true)
     ))
;;

;; read only functions
;;

;; private functions
;;

;; Errors
(define-constant err-owner-only (err u100))
(define-constant err-already-locked (err u101))
(define-constant err-unlock-in-past (err u102))
(define-constant err-no-value (err u103))
(define-constant err-beneficiary-only (err u104))
(define-constant err-unlock-height-not-reached (err u105))
