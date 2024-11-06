setup() {
    bats_load_library bats-support
    bats_load_library bats-assert

    CURRENT_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$CURRENT_DIR/..:$PATH"
    
    apk update
    apk add ruby
}

teardown() {
    apk del ruby
}

@test "show --help" {
    run check_gem --help
    assert_output --partial "Usage: $CURRENT_DIR/../check_gem [OPTIONS]"
    assert_success
}

@test "show -h" {
    run check_gem -h
    assert_output --partial "Usage: $CURRENT_DIR/../check_gem [OPTIONS]"
    assert_success
}

@test "gem command not found" {
    apk del ruby
    run check_gem
    assert_output --partial "UNKNOWN - gem command not found"
    assert_failure
}

@test "ok" {
    run check_gem -w 9999 -c 9999
    assert_output --regexp "^OK - [0-9]+ gem\(s\) need updates$"
    assert_success
}

@test "warning" {
    run check_gem -w 1 -c 9999
    assert_output --regexp "^WARNING - [0-9]+ gem\(s\) need updates$"
    assert_failure
}

@test "critical" {
    run check_gem -w 1 -c 1
    assert_output --regexp "^CRITICAL - [0-9]+ gem\(s\) need updates$"
    assert_failure
}
