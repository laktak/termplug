from ranger.api.commands import *
import os
import shutil


class toggle_termplug(Command):
    """
    :toggle_termplug

    """

    def execute(self):
        p = not self.fm.settings["_termplug"]
        self.fm.settings["_termplug"] = p
        self.fm.execute_console(f"termplug {'%f' if p else ''}")
        status = f"termplug {'active' if p else 'off'}"
        self.fm.notify(status, duration=4)


class termplug(Command):
    """
    :termplug

    """

    def execute(self):
        do_preview = self.fm.settings["_termplug"]
        termplug = shutil.which("termplug")
        try:
            f = self.rest(1)
            if not do_preview:
                self.fm.execute_console(f"shell -s termplug --exit")
            elif not termplug:
                self.fm.notify(f"termplug script not found")
            elif os.path.isfile(f):
                self.fm.notify(f"preview {f}")
                self.fm.execute_console(f"shell -s termplug '{f}'")
        except Exception as e:
            self.fm.notify(e)
