import { SQSEvent } from "aws-lambda";

export const helloListener = async (event: SQSEvent): Promise<void> => {
  console.info(JSON.stringify(event));
  await Promise.all(
    event.Records.map(async (message): Promise<void> => {
      console.info(`==> ${message.messageId}`, message);
    })
  );
};
