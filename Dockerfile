FROM python:3.5
RUN useradd -ms /bin/bash thanuj
USER thanuj
CMD ["/bin/bash"]
# docker run  -it root_python bash where logged in user is thanuj