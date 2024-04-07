from django.contrib.auth.hashers import make_password
from django.db import IntegrityError

from rest_framework.decorators import api_view, APIView, authentication_classes, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status

from knox.auth import AuthToken, TokenAuthentication

from users.serializers import UserSerializer, LoginSerializer
from users.models import User

from core.serializers import ToWatchSerializer
from core.models import ToWatch

@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def user(request):
    try:
        user = request.user
        serializer = UserSerializer(user)

        return Response(data=serializer.data, status=status.HTTP_200_OK)
    except Exception as e:
        return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
@authentication_classes([])
def register(request):
    try:
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        data = serializer.validated_data

        user = User.objects.create(
            first_name=data['first_name'],
            last_name=data['last_name'],
            username=data['username'],
            email=data['email'],
            password=make_password(data['password']),
        )

        token = AuthToken.objects.create(user=user)[1]

        serializer = UserSerializer(user)

        return Response(data={'user': serializer.data, 'token': token,}, status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        return Response(data={'message': 'Email already registered'},status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        print(e)
        return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
@authentication_classes([])
def login(request):
    try:
        serializer = LoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        data = serializer.validated_data

        user = User.objects.filter(email=data['email']).first()

        if not user:
            return Response(data={'message': 'Email or password is invalid'}, status=status.HTTP_400_BAD_REQUEST)
        elif not user.check_password(data['password']):
            return Response(data={'message': 'Email or password is invalid'}, status=status.HTTP_400_BAD_REQUEST)
        
        token = AuthToken.objects.create(user=user)[1]

        serializer = UserSerializer(user)

        return Response(data={'user': serializer.data, 'token': token,}, status=status.HTTP_200_OK)
    except Exception as e:
        return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
class ToWatchView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            serializer = ToWatchSerializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            data = serializer.validated_data

            towatch = ToWatch.objects.create(
                user_id=request.user.id,
                show_id=data['show_id'],
            )

            serializer = ToWatchSerializer(towatch)

            return Response(data=serializer.data, status=status.HTTP_201_CREATED)
        except IntegrityError as e:
            return Response(data={'message': 'Error during add'},status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def get(self, request):
        try:
            towatchs = ToWatch.objects.filter(user_id=request.user.id)

            serializer = ToWatchSerializer(towatchs, many=True)

            return Response(data=serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def delete(self, request, id=None):
        try:
            if id is not None:
                towatch = ToWatch.objects.filter(user_id=request.user.id).filter(show_id=id)
                towatch.delete()

                return Response(status=status.HTTP_204_NO_CONTENT)
            else:
                return Response(status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)