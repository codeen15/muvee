from django.urls import path
from knox.views import LogoutView, LogoutAllView
from . import views

urlpatterns = [
    path('auth/user/', views.user),
    path('auth/register/', views.register),
    path('auth/login/', views.login),
    path('auth/logout/', LogoutView.as_view()),
    path('auth/logout-all/', LogoutAllView.as_view()),
    path('towatch/', views.ToWatchView.as_view()),
    path('towatch/<int:id>/', views.ToWatchView.as_view()),
]