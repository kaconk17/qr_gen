from django.urls import path
from qr_engine import views

urlpatterns = [
    path('/',views.qrPage, name='qrPage'),
    path('genqr',views.generate, name='genqr')
]