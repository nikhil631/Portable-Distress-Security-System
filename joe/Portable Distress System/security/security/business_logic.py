from .miscellaneous import object_creator,object_filter,object_remove
from django.utils import timezone
from django.conf import settings
def add_specific_relative(roll:int,relation:int)->bool:
    """
    Function to relate a relative to a person, required roll which is the id of the logged in user and relation which is id of the relative to be added.
    """
    try:
        if str(relation) in [str(x.relation_id) for x in object_filter(factor={"roll_id":roll},model="relation_users")]:
            raise Exception([1062,"Duplication found"])
        else:
            object_creator(factor={"roll_id":roll,"relation_id":relation},model="relation_users")
            object_creator(factor={"roll_id":relation,"relation_id":roll},model="relation_users")
        return True
    except Exception as e:
        return False

def send_friend_request(roll:int,relation:int)->bool:
    """
    Function to send friend request to a person, required roll which is the id of the logged in user and relation which is id of the relative to be added.
    """
    object_creator({"user_from_id":roll,"user_to_id":relation,"date":timezone.now()},"friend_requests")
    return True
def remove_relative(roll:int,relation:int)->bool:
    """
    Function to remove a friend from relations
    """
    if object_remove({"roll_id":roll,"relation_id":relation},"relation_users") and object_remove({"roll_id":relation,"relation_id":roll}):
        return True
