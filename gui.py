# https://medium.com/analytics-vidhya/how-to-build-your-first-desktop-application-in-python-7568c7d74311
import sys      ##
import os       ##

import main as mod

from time import strftime, localtime
import threading
from time import sleep
from PyQt6.QtGui import QGuiApplication         ##
from PyQt6.QtQml import QQmlApplicationEngine   ##
from PyQt6.QtQuick import QQuickWindow          ##
from PyQt6.QtCore import QObject, pyqtSignal, pyqtSlot

class Backend(QObject):
    def __init__(self):
        QObject.__init__(self)
        # self.graphWidget.setCursor(cursor)

    # signal
    updated = pyqtSignal(str, arguments=['updater'])
    def updater(self, curr_time):
        self.updated.emit(curr_time)
    def bootUp(self):
        t_thread = threading.Thread(target=self._bootUp)
        t_thread.daemon = True
        t_thread.start()
    def _bootUp(self):
        while True:
            curr_time = strftime("%I:%M %p", localtime())
            self.updater(curr_time)
            sleep(0.1)
    
    @pyqtSlot(str)
    def getUser(self, user):
        mod.launch_user(user)
        os.startfile("C:/Users/nonie/AppData/Local/yuzu/yuzu-windows-msvc/yuzu.exe")
        app.quit()


QQuickWindow.setSceneGraphBackend('software')
app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('./UI/nookapp.qml')

back_end = Backend()
engine.rootObjects()[0].setProperty('backend', back_end)
back_end.bootUp()
sys.exit(app.exec())