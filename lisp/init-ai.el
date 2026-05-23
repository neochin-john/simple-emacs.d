(use-package gptel
  :straight t
  :commands (gptel gptel-send)
  :init
  ;; from secrets.el
  ;; (setq my/llm/deepseek-key "sk-xxxx")
  :config
  ;; avoid curl escape on windows, use `--data-binary @xx.json`
  (when sys/win32p
    (setq gptel-curl-file-size-threshold 0))

  (setq my/llm/deepseek-backend
        (gptel-make-deepseek "DeepSeek"
                             :stream t
                             :key (lambda ()
                                    my/llm/deepseek-key)))
  (setq my/llm/moonshot-backend
        (gptel-make-openai "Moonshot"
                           :stream t
                           :host "api.moonshot.cn"
                           :protocol "https"
                           :endpoint "/v1/chat/completions"
                           :key (lambda ()
                                  my/llm/moonshot-key)
                           ;; https://platform.kimi.com/docs/models
                           :models '(kimi-k2.6 kimi-k2.5)))
  (setq my/llm/zhipu-backend
        (gptel-make-openai "Zhipu"
                           :stream t
                           :host "open.bigmodel.cn"
                           :protocol "https"
                           :endpoint "/api/paas/v4/chat/completions"
                           :key (lambda ()
                                  my/llm/zhipu-key)
                           ;; https://bigmodel.cn/pricing
                           :models '(glm-5.1
                                     glm-4.7-flash
                                     glm-4.7
                                     glm-4.5-air)))
  (setq my/llm/qwen-backend
        (gptel-make-openai "Qwen"
                           :stream t
                           :host "dashscope.aliyuncs.com"
                           :protocol "https"
                           :endpoint "/compatible-mode/v1/chat/completions"
                           :key (lambda ()
                                  my/llm/qwen-key)
                           ;; https://bailian.console.aliyun.com/cn-beijing?spm=5176.12818093_47.resourceCenter.1.53b616d0Q5NYxY&tab=doc#/doc/?type=model&url=3026903
                           ;; https://bailian.console.aliyun.com/cn-beijing?spm=5176.12818093_47.resourceCenter.1.53b616d0Q5NYxY&tab=doc#/doc/?type=model&url=2987148
                           :models '(qwen3.6-plus
                                     qwen3.6-flash)))
  (setq my/llm/minimax-backend
        (gptel-make-openai "Minimax"
                           :stream t
                           :host "api.minimaxi.com"
                           :protocol "https"
                           :endpoint "/v1/chat/completions"
                           :key (lambda ()
                                  my/llm/minimax-key)
                           ;; https://platform.minimaxi.com/docs/guides/models-intro
                           :models '(MiniMax-M2.7
                                     MiniMax-M2.7-highspeed
                                     MiniMax-M2.5
                                     MiniMax-M2.5-highspeed)))
  (setq my/llm/githubmodels-backend
        (gptel-make-openai "GithubModels"
                           :stream t
                           ;; :host "models.inference.ai.azure.com"
                           ;; :protocol "https"
                           ;; :endpoint "/chat/completions"
                           :host "models.github.ai"
                           :protocol "https"
                           :endpoint "/inference/chat/completions"
                           :key (lambda ()
                                  my/llm/githubmodels-key)
                           ;; https://github.com/marketplace/models
                           :models '(gpt-4o
                                     gpt-4o-mini
                                     Meta-Llama-3.1-405B-Instruct
                                     Meta-Llama-3.1-8B-Instruct)))
  (setq my/llm/cherryin-backend
        (gptel-make-openai "CherryIN"
                           :stream t
                           :host "open.cherryin.net"
                           :protocol "https"
                           :endpoint "/v1/chat/completions"
                           :key (lambda ()
                                  my/llm/cherryin-key)
                           ;; https://github.com/marketplace/models
                           :models '("agent/deepseek-v3.2(free)"
                                     "deepseek/deepseek-v4-flash(free)")))
  (setq gptel-backends
        (list my/llm/deepseek-backend
              my/llm/moonshot-backend
              my/llm/zhipu-backend
              my/llm/qwen-backend
              my/llm/minimax-backend
              my/llm/githubmodels-backend
              my/llm/cherryin-backend))
  (setq gptel-backend
        my/llm/cherryin-backend)
  ;; current free model: glm-4.7-flash
  (setq gptel-model "deepseek/deepseek-v4-flash(free)"))

(use-package wingman
  :straight (:type git :host github :repo "mjrusso/wingman")
  :defer t

  :init
  ;; No prefix map until you set `wingman-prefix-key' (e.g. "C-c w").
  (setq wingman-prefix-key nil)

  ;; :hook (prog-mode . wingman-mode)

  :config
  (setq wingman-log-level 4)
  (setq wingman-ring-n-chunks 16)
  (setq wingman-llama-endpoint "http://127.0.0.1:6666/infill")

  (when (fboundp 'modus-themes-get-color-value)
    (set-face-attribute 'wingman-overlay-face nil
                        :foreground (modus-themes-get-color-value 'red-warmer)
                        :background (modus-themes-get-color-value 'bg-inactive)))

  (add-to-list 'wingman-disable-predicates
               (lambda ()
                 (or (derived-mode-p 'envrc-file-mode)
                     (derived-mode-p 'direnv-envrc-mode)
                     (when buffer-file-name
                       (let ((fname (file-name-nondirectory buffer-file-name)))
                         (or (string-equal ".env" fname)
                             (string-equal ".envrc" fname)
                             (string-prefix-p ".localrc" fname))))))))

(provide 'init-ai)
