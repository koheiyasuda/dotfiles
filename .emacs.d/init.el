;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; ロードパスの設定
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emacs 23より前のバージョンを利用している場合
;; user-emacs-directory変数が未定義のため以下の設定を追加
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))


;;load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos" "elpa")

;; init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")



;; packageにMELPA追加
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; 自動作成ファイル
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; backup ファイルオープン時のバックアップ (xxx~)
;; ================================================================

;; 実行の有無
(setq make-backup-files t)

;; 格納ディレクトリーの変更
;;   (対象ディレクトリー . 格納ディレクトリー) のリスト
(setq backup-directory-alist '((".*" . "~/.ehist")))


;; 番号付けによる複数保存
(setq version-control     t)  ;; 実行の有無
(setq kept-new-versions   5)  ;; 最新の保持数
(setq kept-old-versions   1)  ;; 最古の保持数
(setq delete-old-versions t)  ;; 範囲外を削除



;; auto-save 自動保存ファイル (#xxx#)
;; ================================================================

;; ;; 実行の有無
;; (setq auto-save-default nil)

;; ;; 格納ディレクトリーの変更
;; ;;   (対象ファイルのパターン . 保存ファイルパス) のリスト
;; (setq auto-save-file-name-transforms
;;       (append auto-save-file-name-transforms
;;       '((".*" "~/tmp/" t))))


;; 保存の間隔
(setq auto-save-timeout 10) ;; 秒   (デフォルト : 30)
(setq auto-save-interval 100) ;; 打鍵 (デフォルト : 300)




;; auto-save-list 自動保存のリスト  (~/.emacs.d/auto-save-list/.saves-xxx)
;; ================================================================

;; 実行の有無
(setq auto-save-list-file-prefix nil)



;; lock ロックファイル (.#xxx)
;; ================================================================

;; 実行の有無
(setq create-lockfiles nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; auto-complete
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; Auto Complete
;;
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; Tips
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ビープ音禁止
(setq ring-bell-function 'ignore)


;; スタート画面(メッセージ)を表示しない
(setq inhibit-startup-screen t)


;; 選択領域を削除キーで一括削除
(delete-selection-mode t)

;; shift + 矢印キーで領域選択
(if (fboundp 'pc-selection-mode)
    (pc-selection-mode))


;; 行頭 kill-line (C-k) で行全体をカット
(setq kill-whole-line t)

;; 読み取り専用バッファーでもカット系でコピー可能
(setq kill-read-only-ok t)


;; ediff 時にフレームを使わない
(setq ediff-window-setup-function 'ediff-setup-windows-plain)


;; png, jpg などのファイルを画像として表示
(setq auto-image-file-mode t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; カスタマイズ
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; カスタマイズ用のファイルを設定
(setq custom-file "~/.emacs.d/custom_setttings.el")

;; カスタマイズ用ファイルをロード
(load custom-file t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; その他
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Macのoptionをメタキーにする
(setq mac-option-modifier 'meta)

;; 行番号を表示
(require 'linum)
(global-linum-mode 1)

;; C-c c で compile コマンドを呼び出す
(define-key mode-specific-map "c" 'compile)
;;ファイル種別と文字コードを関連付け（最優先）
(modify-coding-system-alist 'file "\\.c\\'" 'utf-8-with-signature-dos)
(modify-coding-system-alist 'file "\\.cpp\\'" 'utf-8-with-signature-dos)  

(define-key global-map [?¥] [?\\])  ;; ¥の代わりにバックスラッシュを入力する



(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))


;; C-q をプリフィックスキー化
(define-key global-map "\C-q" (make-sparse-keymap))

;; window-resizer は C-q C-r (resize) で
(global-set-key "\C-q\C-r" 'window-resizer)


;; C-x o にはもううんざり
(define-key global-map (kbd "C-t") 'other-window)

(set-language-environment 'Japanese)    ; 日本語環境
(set-default-coding-systems 'utf-8-unix)    ; UTF-8 が基本
(set-terminal-coding-system 'utf-8-unix)    ; emacs -nw も文字化けしない
(setq default-file-name-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(prefer-coding-system 'utf-8-unix)


;; C-hをbackspaceにする
(global-set-key (kbd "C-h") 'delete-backward-char)


;; yesと入力するのは面倒なのでyで十分
(defalias 'yes-or-no-p 'y-or-n-p)

;; 行頭でC-kを実行した時に1行削除にする
(setq kill-whole-line t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; プログラミング
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 共通
;; ================================================================

;; 左端(文字の前)ではインデント、それ以外はタブの挿入
(setq tab-always-indent nil)
(setq c-tab-always-indent nil)

;; 空白を一度に削除
(if (fboundp 'global-hungry-delete-mode)
    (global-hungry-delete-mode 1))

;; 改行時などに自動でインデント 
;;   (C-j と C-m の入れ替え)
(if (fboundp 'electric-indent-mode)
    (electric-indent-mode 0))

;; 特定の文字を入力すると自動で改行、インデント
;; (electric-layout-mode 1)


;; C 系共通
;; ================================================================

(defun my-all-cc-mode-init ()
  ;; C 系(cc-mode を継承した)モード共通の設定を記述

  ;; 空白などを一度に削除
  (c-toggle-hungry-state 1)

  ;; 改行時などで自動インデント
  (c-toggle-electric-state 1)
  ;; 
  ;; ";", "}" などを入力したときに自動改行
  ;; 自動インデントも一緒に ON になる
  (c-toggle-auto-newline 1)

  )
(add-hook 'c-mode-common-hook 'my-all-cc-mode-init)


;; C, C++
;; ================================================================

(autoload 'vs-set-c-style "vs-set-c-style"
  "Set the current buffer's c-style to Visual Studio like style. ")

(defun my-c-c++-mode-init ()
  ;; C, C++ 用の設定を記述
  

  ;; Visual Studio 風の設定
  ;; (vs-set-c-style)
  )
(add-hook 'c-mode-hook 'my-c-c++-mode-init)
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)


;; .h でも C++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(put 'narrow-to-region 'disabled nil)

;; ヘルプ
(define-key global-map "\M-?" 'help-for-help)




;; auto-installの設定
;;(when (require 'auto-install nil t)
  ;; インストールディレクトリの設定
  ;;(setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiに登録されているelispの名前を取得する
  ;;(auto-install-update-emacswiki-package-name t)
  ;; 必要ならプロキシ設定
  ;; (setq url-proxy-services '(("http" . "localhost:8339")))
  ;; install-elisp の関数を利用可能にする
  ;;(auto-install-compatibility-setup))




;; 折り返しトグルコマンド
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)



;; edit-server用
(when (locate-library "edit-server")
  (require 'edit-server)
  (defvar edit-server-new-frame nil)    ; 新しいフレームは開かない
  (edit-server-start))

;; c言語
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; RET キーで自動改行+インデント
             (define-key c-mode-base-map "\C-m" 'newline-and-indent)
))

;; C言語で記号の前後に自動でスペースを入れる
(add-hook 'c-mode-common-hook #'electric-spacing-mode)

;; flycheck設定
(require 'flycheck)
 
(global-flycheck-mode)
 
(define-key global-map (kbd "\C-qn") 'flycheck-next-error)
(define-key global-map (kbd "\C-qp") 'flycheck-previous-error)
(define-key global-map (kbd "\C-qd") 'flycheck-list-errors)

(add-hook 'c++-mode-hook (lambda()
                           (setq flycheck-gcc-language-standard "c++11")
                           (setq flycheck-clang-language-standard "c++11")))
(setq flycheck-c/c++-clang-executable "/usr/bin/clang")


;; Mac OS Xの場合のファイル名の設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
