from django.db import models

class ToWatch(models.Model):
    id = None
    user_id = models.IntegerField()
    show_id = models.IntegerField()

    class Meta:
        unique_together = ('user_id', 'show_id',)
