from selenium.webdriver import Chrome
driver = Chrome()
driver.implicitly_wait(15) # seconds

import uuid
import requests
import shutil

# we want to store the book object to link our img url and rating
class Book:
    image_src = None
    number_rating = 0
    str_rating = None
    filename = None

    # goodreads has these in the td > span classes, lol
    two_star_str = "it was ok"
    three_star_str = "liked it"
    four_start_str = "really liked it"
    five_star_str = "it was amazing"

    def convert_str(self, str_rating):
        if str_rating == self.two_star_str:
            return 2
        elif str_rating == self.three_star_str:
            return 3
        elif str_rating == self.four_start_str:
            return 4
        elif str_rating == self.five_star_str:
            return 5
        else:
            return -1

    def generate_filename(self, number_rating):
        return str(uuid.uuid1()) + '__' + str(number_rating)

    def __init__(self, image_src, str_rating):
        self.image_src = image_src
        self.str_rating = str_rating
        self.number_rating = self.convert_str(str_rating)
        self.filename = self.generate_filename(self.number_rating)


    def download_image(self):
        resp = requests.get(self.image_src, stream=True)
        local_file = open(self.filename, 'wb')
        resp.raw.decode_content = True
        shutil.copyfileobj(resp.raw, local_file)
        del resp
    


book_list_url = "https://www.goodreads.com/review/list/84343841-bram?read_at=2019" 

# the books i read in 2019
driver.get(book_list_url)

# grab only imgs with "cover" in id
img_elems = driver.find_elements_by_xpath('//img[contains(@id, "cover")]')
# grab rating elems
rating_elems = driver.find_elements_by_class_name('staticStars')


books = []

print len(rating_elems)

for (img_el, rating_el) in zip(img_elems, rating_elems):
    img_src = img_el.get_attribute("src")
    title_attr = rating_el.get_attribute("title")
    book = Book(img_src, title_attr)
    books.append(book)


# uncomment this to download all the book images
for book in books:
    book.download_image()
