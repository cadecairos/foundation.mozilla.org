from django.conf.urls import url
from networkapi.fellows import views

urlpatterns = [
    url(r'^$', views.fellows_home),
    url(r'^type/', views.fellows_type),
]
