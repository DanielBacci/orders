from unittest import mock

import pytest


class TestHealthCheck:

    @pytest.fixture
    def url(self):
        return '/healthcheck/'

    async def test_should_return_status_ok(self, client, url):
        async with client.get(url) as response:
            assert response.status == 200
            content = await response.json()

        assert content == {'status': 'OK'}


class TestMonitor:

    @pytest.fixture
    def url(self):
        return '/monitor/'

    async def test_should_return_cache_ok(self, client, url):
        async with client.get(url) as response:
            assert response.status == 200
            content = await response.json()

        assert any(content.values())

    async def test_should_return_cache_off_if_cache_check_fail(
        self,
        client,
        url
    ):
        cache_mock = mock.Mock()
        cache_mock.check.side_effect = ValueError('some error')

        with mock.patch(
            'orders.healthcheck.views.MonitorView.VALIDATOR_CLASSES',
            [cache_mock]
        ) as mock_caches:
            async with client.get(url) as response:
                assert response.status == 500
                content = await response.json()

        assert any(content.values())
