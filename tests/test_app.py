from app.wsgi import app

def test_health_check():
    tester = app.test_client()
    response = tester.get('/healthz')
    assert response.status_code == 200
    assert response.data == b"OK"
