from django.shortcuts import render
from django.http import JsonResponse
import pyqrcode

def qrPage(request):
    return render(request, 'index.html',{})

def generate(request):
    txt = request.POST.get('inputan')
    img = pyqrcode.create(txt)
    img_str = img.png_as_base64_str(scale=5)
    return JsonResponse({
        'success' : True,
        'message' : "Data berhasil disimpan",
        'img' : img_str
    })

