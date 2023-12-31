#!/usr/bin/env python3
import unittest
import app

class TestHello(unittest.TestCase):

    def setUp(self):
        app.app.testing = True
        self.app = app.app.test_client()

    def test_index_route(self):
        response = self.app.get('/')
        self.assertEqual(response.status, '200 OK')
        html_content = response.data.decode("utf-8")

        self.assertIn("<title>Flask Cats</title>", html_content)
        self.assertIn("<h4>Cat Gif of the day</h4>", html_content)


if __name__ == '__main__':
    unittest.main()
