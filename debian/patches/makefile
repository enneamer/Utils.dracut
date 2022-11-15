--- a/Makefile
+++ b/Makefile
@@ -9,6 +9,8 @@
 DRACUT_FULL_VERSION = $(DRACUT_VERSION)
 endif
 
+DRACUT_FULL_VERSION = $(shell dpkg-parsechangelog -SVersion)
+
 HAVE_SHELLCHECK ?= $(shell which shellcheck >/dev/null 2>&1 && echo yes)
 HAVE_SHFMT ?= $(shell which shfmt >/dev/null  2>&1 && echo yes)
 HAVE_RPMBUILD ?= $(shell which rpmbuild >/dev/null  2>&1 && echo yes)
