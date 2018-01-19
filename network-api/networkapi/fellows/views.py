from django.shortcuts import render


# Create your views here.
def fellows_home(request):
    return render(request, 'fellows_home.html')

def fellows_type(request):
    return render(request, 'fellows_type.html')
