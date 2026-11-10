;;; init-proxy.el --- Global proxy settings -*- lexical-binding: t; -*-

(defconst my/proxy/host "127.0.0.1"
  "Proxy server host.")

(defconst my/proxy/port 7890
  "Proxy server port.")

(defconst my/proxy/no-proxy
  "^\\(localhost\\|127\\.0\\.0\\.1\\|10\\..*\\|192\\.168\\..*\\)"
  "Hosts that should bypass the proxy.")

(defconst my/proxy/address
  (format "%s:%s" my/proxy/host my/proxy/port)
  "Proxy address in HOST:PORT form.")

(defun my/proxy/enable ()
  "Enable global proxy for url.el and subprocesses."
  (interactive)
  (setq url-proxy-services
        `(("no_proxy" . ,my/proxy/no-proxy)
          ("http" . ,my/proxy/address)
          ("https" . ,my/proxy/address)))
  (setenv "http_proxy" (concat "http://" my/proxy/address))
  (setenv "https_proxy" (concat "http://" my/proxy/address))
  (setenv "no_proxy" my/proxy/no-proxy)
  (message "Proxy enabled: %s" my/proxy/address))

(defun my/proxy/disable ()
  "Disable global proxy."
  (interactive)
  (setq url-proxy-services nil)
  (dolist (var '("http_proxy" "https_proxy" "no_proxy"))
    (setenv var nil))
  (message "Proxy disabled"))

(defun my/proxy/toggle ()
  "Toggle global proxy on/off."
  (interactive)
  (if url-proxy-services
      (my/proxy/disable)
    (my/proxy/enable)))

(provide 'init-proxy)
;;; init-proxy.el ends here
