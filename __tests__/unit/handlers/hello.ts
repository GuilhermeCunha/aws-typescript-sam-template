import { hello } from "../../../src/handlers/hello";

// This includes all tests for putItemHandler()
describe("Test hello handler", function () {
  // This test invokes putItemHandler() and compare the result
  it("should return formated response", async () => {
    const event = {
      httpMethod: "POST",
      body: '{"id": "id1","name": "name1"}',
    } as any;

    const result = await hello(event);

    expect(result.statusCode).toBeDefined();
  });
  it("should not accept GET", async () => {
    const event = {
      httpMethod: "GET",
      body: '{"id": "id1","name": "name1"}',
    } as any;

    const result = await hello(event);

    expect(result.statusCode).toBe(404);
  });
});
