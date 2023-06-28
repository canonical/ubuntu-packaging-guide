default:
	$(MAKE) -C docs

%:
	$(MAKE) -C docs $@
