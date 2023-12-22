FROM ghcr.io/wg-easy/wg-easy

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]