<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use Exception;
use Ramsey\Uuid\Uuid;

/**
 * @ORM\Entity()
 */
class Project
{
    /**
     * The unique auto incremented primary key.
     *
     * @ORM\Id
     * @ORM\Column(type="integer", options={"unsigned": true}, name="project_id")
     * @ORM\GeneratedValue
     */
    protected int $id;

    /**
     * @ORM\Column(type="string", unique=true, length=36)
     */
    protected ?string $uuid;

    /**
     * Account constructor.
     *
     * @param ?string $uuid
     *
     * @throws Exception
     */
    public function __construct(string $uuid = null)
    {
        $this->uuid = $uuid;
        if (is_null($this->uuid)) {
            $this->uuid = Uuid::uuid4()->toString();
        }
    }

}
