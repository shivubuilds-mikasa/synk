import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';

const clipboardState = vi.hoisted(() => ({ text: '' }));

vi.mock('electron', () => ({
  clipboard: {
    readText: () => clipboardState.text,
    writeText: (text: string) => {
      clipboardState.text = text;
    },
  },
}));

import { ClipboardService } from './clipboard-service';

describe('ClipboardService', () => {
  beforeEach(() => {
    clipboardState.text = 'initial';
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('emits newly copied system clipboard text', async () => {
    const service = new ClipboardService(10);
    const changed = new Promise<string>((resolve) => service.once('change', resolve));
    service.startPolling();
    clipboardState.text = 'copied on desktop';

    await expect(changed).resolves.toBe('copied on desktop');
    service.dispose();
  });

  it('does not re-emit text received from another device', async () => {
    const service = new ClipboardService(10);
    const onChange = vi.fn();
    service.on('change', onChange);
    service.write('received from phone');
    service.startPolling();

    await new Promise((resolve) => setTimeout(resolve, 40));

    expect(clipboardState.text).toBe('received from phone');
    expect(onChange).not.toHaveBeenCalled();
    service.dispose();
  });
});
