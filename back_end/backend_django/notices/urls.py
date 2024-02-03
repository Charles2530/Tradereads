from django.urls import path
from notices.views import *

urlpatterns = [
    path('notices/', NoticeListCreateAPIView, name='notice-list-create'),
    path('notices/', ShowCurrentUserNoticeAPIView, name='show-current-user-notice'),
    path('have_new_notice/', HaveNewNoticeAPIView, name='have-new-notice'),
]
