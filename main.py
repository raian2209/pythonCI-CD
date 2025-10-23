from fastapi import FastAPI, status
from pydantic import BaseModel

app = FastAPI()

class HealthCheck(BaseModel):
    status: str = "OK"

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/teste")
async def teste():
    return {"message": "Teste CI-CD"}

@app.get(
    "/health",
    tags=["healthcheck"],
    summary="Perform a Health Check",
    response_description="Return HTTP Status Code 200 (OK)",
    status_code=status.HTTP_200_OK,
    response_model=HealthCheck,
)
def get_health() -> HealthCheck:
    """
    ## Perform a Health Check
    Endpoint to perform a healthcheck on. 
    """
    return HealthCheck(status="OK")