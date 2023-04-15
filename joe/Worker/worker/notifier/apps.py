from django.apps import AppConfig
import atexit

class NotifierConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'notifier'

    def ready(self):
        from .miscellaneous import scheduler,stop_scheduler,start_scheduler
        start_scheduler()
        self.scheduler = scheduler
        atexit.register(stop_scheduler)