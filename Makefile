ci-all: \
	ci-fmt \
	ci-cargo-deny \
	ci-clippy \
	ci-clippy-fuzz \
	ci-check \
	ci-test

ci-fmt:
	cargo +nightly fmt --check

ci-cargo-deny:
	cargo deny check advisories

ci-clippy:
	cargo clippy --workspace --all-targets -- -Dwarnings

ci-clippy-fuzz:
	cd plugin/fuzz && cargo clippy --workspace --all-targets -- -Dwarnings

PACKAGES=richat-cli richat-client richat-plugin richat richat-shared
ci-check:
	for package in $(PACKAGES) ; do \
		echo cargo check -p $$package --all-targets --all-features ; \
		cargo check -p $$package --all-targets --all-features ; \
	done

ci-test:
	cargo test --all-targets
