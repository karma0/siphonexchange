FROM python
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
ENV VAULT_ADDR http://vault.coolly.ninja:8200
ENTRYPOINT ["python"]
CMD ["app.py"]
