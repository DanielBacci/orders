from tortoise import fields
from tortoise.models import Model


class ItemModel(Model):
    id = fields.IntField(pk=True)
    order_id = fields.TextField()

    def __str__(self):
        return self.order_id
