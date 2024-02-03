from django.urls import path
from notices.views import *

urlpatterns = [
    path('notices/', NoticeListCreateAPIView.as_view(), name='notice-list-create'),
    path('notices/', ShowCurrentUserNoticeAPIView.as_view(), name='show-current-user-notice'),
    path('have_new_notice/', HaveNewNoticeAPIView.as_view(), name='have-new-notice'),
]
