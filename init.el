;;---------------------------------------------------------------------
;; path関係
;;---------------------------------------------------------------------
;; load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;;---------------------------------------------------------------------
;; 設定ファイルの場所を読み込み設定にする
;; conf :          分割設定用のディレクトリ
;; elisp :         elispインストールディレクトリ
;; public_repos : 公開リポジトリから拡張機能をチェックアウトするディレクトリ
;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")

;;---------------------------------------------------------------------
;; init-loaderの設定
;;---------------------------------------------------------------------
(require 'init-loader)
(defun init-loader-re-load (re dir &optional sort)
  (let ((load-path (cons dir load-path)))
    (dolist (el (init-loader--re-load-files re dir sort))
      (condition-case e
          (let ((time (car (benchmark-run (load (file-name-sans-extension el))))))
            (init-loader-log (format "loaded %s. %s" (locate-library el) time)))
        (error
         ;; (init-loader-error-log (error-message-string e)) ；削除
         (init-loader-error-log (format "%s. %s" (locate-library el) (error-message-string e))) ;追加
         )))))

;; 設定ファイルのあるフォルダを指定
(setq inits_dir (expand-file-name "~/.emacs.d/inits/"))
(init-loader-load inits_dir)
;; emacs起動時にエラーを報告する
(setq init-loader-show-log-after-init t)

;; 参考 http://fukuyama.co/emacsd

