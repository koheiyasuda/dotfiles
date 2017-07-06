;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 初期表示位置、サイズ
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Mac用フォント設定
;; http://tcnksm.sakura.ne.jp/blog/2012/04/02/emacs/

 ;; 英語
 (set-face-attribute 'default nil
             :family "Menlo" ;; font
             :height 125)    ;; font size

;; 日本語
(set-fontset-font
 nil 'japanese-jisx0208
  ;;(font-spec :family "Hiragino Mincho Pro")) ;; font
  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 半角と全角の比を1:2にしたければ
(setq face-font-rescale-alist
;;        '((".*Hiragino_Mincho_pro.*" . 1.2)))
      '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)))  ;; Mac用フォント設定

;;; モードラインに時刻を表示する
(display-time)

;;; 現在行に色をつける
(global-hl-line-mode 1)

;;; メニューバーとツールバーとスクロールバーを消す
;;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)


;; for window system
(if window-system 
    (progn
      (set-frame-parameter nil 'alpha 100)))



;; 起動時に2分割
(setq w (selected-window))
(setq w2 (split-window w nil t))

;; EmacsのWindowを一番上に表示
(if (eq window-system 'ns)
    (x-focus-frame nil))

;; コメントの色を変更
(set-face-foreground 'font-lock-comment-face "salmon")
(set-face-foreground 'font-lock-comment-delimiter-face "salmon")
