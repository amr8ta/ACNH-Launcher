import os
import glob
import shutil
from datetime import datetime


def update_login_record(user):
    login_record = open("last_login.txt", "r")
    last_user = login_record.read()
    login_record.close()
    
    if (user == last_user):
        return 0
    
    login_record = open("last_login.txt", "w")
    login_record.write(user)
    login_record.close()

    return last_user



def generate_dir(dir):
    now = str(datetime.now()).replace(':', '.')

    path = os.path.join(dir, now)
    os.mkdir(path)

    print(f'{path} backup created')
    return (path + '/')



# moving files from main directory to back-up directory
def back_up_files(user):
    dir1 = generate_dir("./users/" + user + '/')

    for files in os.listdir(dir_main):
        shutil.move(dir_main + files, dir1 + files)
    
    print(f'{user}\'s save files backed up')



def load_save_files(user):
    # most recent back-up path
    files = glob.glob("./users/" + user + '/*')
    dir = max(files, key=os.path.getctime).replace("\\", "/") + '/'

    
    for files in os.listdir(dir):
        if(files == 'Villager0'):
            continue
        shutil.copy2(dir + files, dir_main + files)
    
    shutil.copytree(dir + 'Villager0', dir_main + 'Villager0', copy_function=shutil.copy2)

    print(f'{user}\'s save files loaded')



# swap out user1's files in save location with user2's
# dir_main -> user1 (move)
# user2 -> dir_main (copy)
def swap_save_files(user1, user2):

    back_up_files(user1)
    load_save_files(user2)



dir_main = "" + '/'

def launch_user(current_user):
    # current_user = input('Username: ').lower()

    last_user = update_login_record(current_user)
    if (last_user):
        swap_save_files(last_user, current_user)

    # os.startfile("C:/Users/nonie/Desktop/crippling addictions/yuzu.lnk")