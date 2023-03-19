import nginx


def test_nginx():
    passTest = nginx.run_nginx_container("Hello, world!")
    assert (passTest)


def test_fail_nginx():
    passTest = nginx.run_nginx_container("Hello")
    assert (passTest)
