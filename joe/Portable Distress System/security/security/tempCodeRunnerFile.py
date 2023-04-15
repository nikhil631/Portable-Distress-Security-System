
sys.path.append('E:\Important Programs\Joy-of-Engineering\joe\Portable Distress System\security')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'security.settings')
django.setup()

# Redis connection from url
redis_conn = redis.StrictR