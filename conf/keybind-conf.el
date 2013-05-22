;; global-set-keyよりもエラーが少ない
(keyboard-translate ?\C-h ?\C-?)  ; translate `C-h' to DEL

;; Meadow にあったバッファ移動
(global-set-key [?\C->] 'next-buffer)
(global-set-key [?\C-<] 'previous-buffer)

;; suspendが好きなではないので、外す。
(global-unset-key "\C-z")
