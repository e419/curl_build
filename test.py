#!/usr/bin/env python
# -*- coding: utf-8 -*-


""" Dummy CLI tests  """


import unittest
import subprocess


class ImageTest(unittest.TestCase):
    """ Subprocess based test to execute docker client """
    
    def test_version(self):
        """  
        .. code-block::

            docker run -t --rm curl --version
        """
        self.assertIn('curl', subprocess.check_output(['docker', 'run', '-t', '--rm', 'e419/curl', '--version']))

    def test_url(self):
        """ Running container url retrieval 
        .. code-block::

            docker run -t --rm e419/curl http://google.com        
        """
        self.assertIn(
            '301 Moved',
            subprocess.check_output(['docker', 'run', '-t', '--rm', 'e419/curl', 'http://google.com']))


if __name__ == "__main__":
    unittest.main()
