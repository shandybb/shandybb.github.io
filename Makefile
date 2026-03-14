PORT   ?= 3000
BRANCH := main
REMOTE := origin

.PHONY: help serve open deploy status

# ── Default: show help ──────────────────────────────────────────────────────
help:
	@echo ""
	@echo "  Baby Shower Site — Local Dev"
	@echo "  ─────────────────────────────"
	@echo "  make serve    Start local dev server on http://localhost:$(PORT)"
	@echo "  make open     Open the site in your default browser"
	@echo "  make deploy   Commit all changes and push to GitHub Pages"
	@echo "  make status   Show current git status"
	@echo ""
	@echo "  Override port:  make serve PORT=8080"
	@echo ""

# ── Local dev server (Python built-in) ─────────────────────────────────────
serve:
	@echo "Serving at http://localhost:$(PORT)  (Ctrl-C to stop)"
	@python3 -m http.server $(PORT) --directory .

# ── Open browser ────────────────────────────────────────────────────────────
open:
	@xdg-open http://localhost:$(PORT) 2>/dev/null || \
	 open      http://localhost:$(PORT) 2>/dev/null || \
	 echo "Open http://localhost:$(PORT) in your browser"

# ── Deploy: stage, commit, push ─────────────────────────────────────────────
deploy:
	@if [ -z "$$(git status --porcelain)" ]; then \
		echo "Nothing to commit — pushing current HEAD."; \
	else \
		git add -A; \
		read -r -p "Commit message (default: 'Update site'): " msg; \
		msg=$${msg:-Update site}; \
		git commit -m "$$msg"; \
	fi
	git push $(REMOTE) $(BRANCH)
	@echo ""
	@echo "  Deployed! Live at: https://shandybb.github.io"
	@echo ""

# ── Status ───────────────────────────────────────────────────────────────────
status:
	git status
