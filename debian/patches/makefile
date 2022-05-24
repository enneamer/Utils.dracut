--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,7 @@
 -include dracut-version.sh
 
+DEB_VERSION = $(shell dpkg-parsechangelog -SVersion)
+
 DRACUT_MAIN_VERSION ?= $(shell env GIT_CEILING_DIRECTORIES=$(CWD)/.. git describe --abbrev=0 --tags --always 2>/dev/null || :)
 ifeq ($(DRACUT_MAIN_VERSION),)
 DRACUT_MAIN_VERSION = $(DRACUT_VERSION)
@@ -221,7 +223,7 @@
 
 dracut-version.sh:
 	@rm -f dracut-version.sh
-	@printf "#!/bin/sh\n# shellcheck disable=SC2034\nDRACUT_VERSION=%s\n" "$(DRACUT_FULL_VERSION)" > dracut-version.sh
+	@printf "#!/bin/sh\n# shellcheck disable=SC2034\nDRACUT_VERSION=%s\n" "$(DEB_VERSION)" > dracut-version.sh
 
 clean:
 	$(RM) *~
