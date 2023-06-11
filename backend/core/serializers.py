from rest_framework import serializers

class ToWatchSerializer(serializers.Serializer):
    show_id = serializers.IntegerField()