ebookDownloader
===============

Vital Source Ebook Downloader

About
-----
This project was designed to create a pdf from an online textbook viewed through Vital Source's Bookshelf in-browswer 
viewer. When the user supplies their information (username, password, book url, and number of pages), the script goes 
out and downloads the pages from the online textbook and compiles them as a pdf.

All downloads are stored in a timestamped folder inside the user's Documents directory. This script is designed to run
on Windows and was tested on a Windows 7 pc. Some modification of the paths variables might be required in order for it
to be run on a Linux or OS X machine.

Requirements
------------
Windows 7 (tested but should work on other OS')
Ruby 1.9.3
Curl for Windows (must be in path)
Internet connection

Example Usage
-------------
Run the script by typing:

  `ruby main.rb`

  `Enter Email: user@aol.com`

  `Enter Password: abc123`

  `Enter Book URL: https://online.vitalsource.com/signin?return=/books/9781121125216/pages/18503748`

  `Enter # Pages: 475`


The book url you enter should be the URL the browser takes you to once you try to access a book through Vital Source's
website if you're not signed in. Assuming you have a Vital Source account associated with the book you want to view,
the script should be able to retrieve the book and download it as a PDF.
