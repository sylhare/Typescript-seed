import { hello } from '../src';

describe('Test suite', () => {
    it('should say hello', () => {
        expect(hello()).toEqual('Hello, World!')
    })
})