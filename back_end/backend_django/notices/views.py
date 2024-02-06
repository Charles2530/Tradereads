from rest_framework.views import APIView
from rest_framework.response import Response
from users.models import Users
from notices.models import Notices


# Create your views here.
class NoticeListCreateAPIView(APIView):
    def post(self, request):
        if request.user.rights != Users.UserType.ADMIN:
            return Response({
                'success': False,
                'message': '权限不足'
            })
        title = request.data.get('title')
        content = request.data.get('content')
        notice = Notices.objects.create({
            'title': title,
            'content': content,
            'notice_type': Notices.NoticeType.SYSTEM,
            'user_id': request.user.id
        })
        return Response({
            'success': True,
            'message': '创建成功',
            'data': {
                'notice_id': notice.id,
                'notice_create_time': notice.create_time
            }
        })


class ShowCurrentUserNoticeAPIView(APIView):
    def get(self, request):
        all_notices = Notices.objects.filter(user_id=request.user.id)
        notices = []
        for notice in all_notices:
            notices.append({
                'notice_type': notice.notice_type,
                'notice_user_id': notice.user_id,
                'notice_title': notice.title,
                'notice_content': notice.content,
                'notice_create_time': notice.create_time,
                'notice_readed': notice.notice_readed
            })
            notice.notice_readed = True
            notice.save()
        return Response({
            'success': True,
            'data': {
                'notices': notices
            }
        })


class HaveNewNoticeAPIView(APIView):
    def get(self, request):
        notices = Notices.objects.filter(user_id=request.user.id, notice_readed=False)
        return Response({
            'success': True,
            'data': {
                'have_new_notice': len(notices) > 0
            }
        })
